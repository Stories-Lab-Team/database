// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@tableland/evm/contracts/utils/TablelandDeployments.sol";
import "@tableland/evm/contracts/utils/SQLHelpers.sol";
import "@openzeppelin/contracts/token/ERC721/utils/ERC721Holder.sol";
import "@openzeppelin/contracts/utils/Strings.sol";


contract StoryDataBase is ERC721Holder {
  uint256 public tableId;
  string private constant _TABLE_PREFIX = "story_database";
  uint256 public dataCount = 0;

  constructor() {
    tableId = TablelandDeployments.get().create(
      address(this),
      SQLHelpers.toCreateFromSchema(
        "id integer primary key,"
        "title text,"
        "description text,"
        "creator text,"
        "creation_day text,"
        "image_url text,"
        "openForCollab integer",
        // "language text,"
        // "category text,"
        // "word_count integer",
        _TABLE_PREFIX
      )
    );
  }

  function addStory(
    string memory title,
    string memory description,
    string memory image_url,
    bool openForCollab
    // string memory language
    // string memory category,
    // uint256 word_count
  ) public {
    dataCount++;
    
    TablelandDeployments.get().mutate(
        address(this),
        tableId,
        SQLHelpers.toInsert(
        _TABLE_PREFIX,
        tableId,
        // "id,title,description,creator,creation_day,image_url,openForCollab,language,category,word_count",
        "id,title,description,creator,creation_day,image_url,openForCollab",
        string.concat(
            Strings.toString(dataCount),
            ",",
            SQLHelpers.quote(title),
            ",",
            SQLHelpers.quote(description),
            ",",
            SQLHelpers.quote(Strings.toHexString(msg.sender)),
            ",",
            SQLHelpers.quote(Strings.toString(block.timestamp)),
            ",",
            SQLHelpers.quote(image_url),
            ",",
            openForCollab ? "1" : "0"
            // ",",
            // SQLHelpers.quote(language)
            // ",",
            // SQLHelpers.quote(category),
            // ",",
            // SQLHelpers.quote(Strings.toString(word_count))
          )
        )
    );
  }

  function getTableName() external view returns (string memory) {
    return SQLHelpers.toNameFromId(_TABLE_PREFIX, tableId);
  }
}