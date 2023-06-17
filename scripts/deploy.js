// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
const hre = require("hardhat");

async function main() {
  // const StoryDataBase = await hre.ethers.getContractFactory("StoryDataBase");
  // const storyDataBase = await StoryDataBase.deploy();
  // await storyDataBase.deployed();
  // console.log(`StoryDataBase deployed to ${storyDataBase.address}`);

  // const data = {
  //   "title": "Neon Night Runners",
  //   "description": "In the heart of Neo-Tokyo, a group of runners defy the corporation controlling the city.",
  //   "image_url": "https://via.placeholder.com/150",
  //   "openForCollab": true,
  //   "language": "English",
  //   "category": "Horror",
  //   "word_count": 100
  // }

  // await storyDataBase.addStory(
  //   data.title,
  //   data.description,
  //   data.image_url,
  //   data.openForCollab
  //   // data.language,
  //   // data.category,
  //   // data.word_count
  // );
  // console.log(`Story #1 is created`);

  // const tablename = await storyDataBase.getTableName();
  // console.log(`Name-> ${tablename}`);

  const ThemeDataBase = await hre.ethers.getContractFactory("ThemeDataBase");
  const themeDataBase = await ThemeDataBase.deploy();
  await themeDataBase.deployed();
  console.log(`ThemeDataBase deployed to ${themeDataBase.address}`);

  const data = {
    "title": "The Power of Music",
    "description": "In the heart of Neo-Tokyo, a group of runners defy the corporation controlling the city.",
    "number_of_collaboration": 7,
    "keywords": "Music",
    "messages": "Testing"
  }

  await themeDataBase.addTheme(
    data.title,
    data.description,
    data.number_of_collaboration,
    data.keywords,
    // data.messages
  );
  console.log(`Theme #1 is created`);

  const tablename = await themeDataBase.getTableName();
  console.log(`Name-> ${tablename}`);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
