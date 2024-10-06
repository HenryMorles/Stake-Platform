const { ethers } = require("hardhat");

async function main() {
    const initialSupply = "1000000";

    const FortY = await ethers.getContractFactory("FortY");
    
    const fortY = await FortY.deploy(initialSupply);

    await fortY.waitForDeployment();

    console.log(`FortY token deployed to: ${fortY.target}`);
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
