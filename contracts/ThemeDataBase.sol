// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@tableland/evm/contracts/utils/TablelandDeployments.sol";
import "@tableland/evm/contracts/utils/SQLHelpers.sol";
import "@openzeppelin/contracts/token/ERC721/utils/ERC721Holder.sol";
import "@openzeppelin/contracts/utils/Strings.sol";


contract ThemeDataBase is ERC721Holder {
  uint256 public tableId;
  string private constant _TABLE_PREFIX = "theme_database";
  uint256 public dataCount = 0;

  constructor() {
    tableId = TablelandDeployments.get().create(
      address(this),
      SQLHelpers.toCreateFromSchema(
        "id integer primary key,"
        "title text,"
        "description text,"
        "creator text,"
        "number_of_collaboration integer,"
        "keywords text",
        _TABLE_PREFIX
      )
    );
  }

  function addTheme(
    string memory title,
    string memory description,
    uint256 number_of_collaboration,
    string memory keywords
  ) public {
    dataCount++;
    
    TablelandDeployments.get().mutate(
        address(this),
        tableId,
        SQLHelpers.toInsert(
        _TABLE_PREFIX,
        tableId,
        "id,title,description,creator,number_of_collaboration,keywords",
        string.concat(
            Strings.toString(dataCount),
            ",",
            SQLHelpers.quote(title),
            ",",
            SQLHelpers.quote(description),
            ",",
            SQLHelpers.quote(Strings.toHexString(msg.sender)),
            ",",
            SQLHelpers.quote(Strings.toString(number_of_collaboration)),
            ",",
            SQLHelpers.quote(keywords)
          )
        )
    );
  }

  function getTableName() external view returns (string memory) {
    return SQLHelpers.toNameFromId(_TABLE_PREFIX, tableId);
  }
}