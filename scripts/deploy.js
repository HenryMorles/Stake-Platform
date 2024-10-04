// Импортируем необходимые библиотеки из Hardhat
const { ethers } = require("hardhat");

async function main() {
    const initialSupply = "1000000"; // Начальное количество токенов

    // Получаем контракт-фабрику для нашего токена
    const FortY = await ethers.getContractFactory("FortY");
    // Разворачиваем контракт с начальным количеством токенов
    const fortY = await FortY.deploy(initialSupply);

    // Ждем, пока контракт будет развернут
    await fortY.waitForDeployment();

    console.log(`FortY token deployed to: ${fortY.target}`);
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
