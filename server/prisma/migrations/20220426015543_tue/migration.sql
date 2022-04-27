/*
  Warnings:

  - You are about to drop the column `createAt` on the `Bills` table. All the data in the column will be lost.
  - You are about to drop the column `deleteAt` on the `Bills` table. All the data in the column will be lost.
  - You are about to drop the column `nobill` on the `Bills` table. All the data in the column will be lost.
  - You are about to drop the column `updateAt` on the `Bills` table. All the data in the column will be lost.
  - You are about to drop the column `createAt` on the `Categories` table. All the data in the column will be lost.
  - You are about to drop the column `deleteAt` on the `Categories` table. All the data in the column will be lost.
  - You are about to drop the column `updateAt` on the `Categories` table. All the data in the column will be lost.
  - You are about to drop the column `createAt` on the `Outlets` table. All the data in the column will be lost.
  - You are about to drop the column `deleteAt` on the `Outlets` table. All the data in the column will be lost.
  - You are about to drop the column `updateAt` on the `Outlets` table. All the data in the column will be lost.
  - You are about to drop the column `createAt` on the `Products` table. All the data in the column will be lost.
  - You are about to drop the column `deleteAt` on the `Products` table. All the data in the column will be lost.
  - You are about to drop the column `updateAt` on the `Products` table. All the data in the column will be lost.
  - You are about to alter the column `price` on the `Products` table. The data in that column could be lost. The data in that column will be cast from `Int` to `Double`.
  - You are about to drop the column `createAt` on the `Users` table. All the data in the column will be lost.
  - You are about to drop the column `deleteAt` on the `Users` table. All the data in the column will be lost.
  - You are about to drop the column `updateAt` on the `Users` table. All the data in the column will be lost.
  - You are about to drop the `Lisbill` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `name` to the `Bills` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updatedAt` to the `Bills` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updatedAt` to the `Categories` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updatedAt` to the `Outlets` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updatedAt` to the `Products` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updatedAt` to the `Users` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE `Bills` DROP FOREIGN KEY `Bills_productsId_fkey`;

-- DropForeignKey
ALTER TABLE `Categories` DROP FOREIGN KEY `Categories_outletsId_fkey`;

-- DropForeignKey
ALTER TABLE `Lisbill` DROP FOREIGN KEY `Lisbill_billsId_fkey`;

-- DropForeignKey
ALTER TABLE `Outlets` DROP FOREIGN KEY `Outlets_usersId_fkey`;

-- DropForeignKey
ALTER TABLE `Products` DROP FOREIGN KEY `Products_categoriesId_fkey`;

-- DropIndex
DROP INDEX `Users_email_key` ON `Users`;

-- AlterTable
ALTER TABLE `Bills` DROP COLUMN `createAt`,
    DROP COLUMN `deleteAt`,
    DROP COLUMN `nobill`,
    DROP COLUMN `updateAt`,
    ADD COLUMN `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    ADD COLUMN `listBillId` VARCHAR(191) NULL,
    ADD COLUMN `name` VARCHAR(191) NOT NULL,
    ADD COLUMN `updatedAt` DATETIME(3) NOT NULL,
    MODIFY `productsId` VARCHAR(191) NULL;

-- AlterTable
ALTER TABLE `Categories` DROP COLUMN `createAt`,
    DROP COLUMN `deleteAt`,
    DROP COLUMN `updateAt`,
    ADD COLUMN `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    ADD COLUMN `updatedAt` DATETIME(3) NOT NULL,
    MODIFY `outletsId` VARCHAR(191) NULL;

-- AlterTable
ALTER TABLE `Outlets` DROP COLUMN `createAt`,
    DROP COLUMN `deleteAt`,
    DROP COLUMN `updateAt`,
    ADD COLUMN `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    ADD COLUMN `updatedAt` DATETIME(3) NOT NULL,
    MODIFY `usersId` VARCHAR(191) NULL;

-- AlterTable
ALTER TABLE `Products` DROP COLUMN `createAt`,
    DROP COLUMN `deleteAt`,
    DROP COLUMN `updateAt`,
    ADD COLUMN `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    ADD COLUMN `description` VARCHAR(191) NULL,
    ADD COLUMN `updatedAt` DATETIME(3) NOT NULL,
    ADD COLUMN `usersId` VARCHAR(191) NULL,
    MODIFY `price` DOUBLE NOT NULL,
    MODIFY `categoriesId` VARCHAR(191) NULL;

-- AlterTable
ALTER TABLE `Users` DROP COLUMN `createAt`,
    DROP COLUMN `deleteAt`,
    DROP COLUMN `updateAt`,
    ADD COLUMN `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    ADD COLUMN `updatedAt` DATETIME(3) NOT NULL;

-- DropTable
DROP TABLE `Lisbill`;

-- CreateTable
CREATE TABLE `Profiles` (
    `id` VARCHAR(191) NOT NULL,
    `firstName` VARCHAR(191) NULL,
    `lastName` VARCHAR(191) NULL,
    `address` VARCHAR(191) NULL,
    `city` VARCHAR(191) NULL,
    `state` VARCHAR(191) NULL,
    `zip` VARCHAR(191) NULL,
    `phone` VARCHAR(191) NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,
    `usersId` VARCHAR(191) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Roles` (
    `id` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,
    `employeesId` VARCHAR(191) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Employees` (
    `id` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `address` VARCHAR(191) NULL,
    `city` VARCHAR(191) NULL,
    `state` VARCHAR(191) NULL,
    `zip` VARCHAR(191) NULL,
    `phone` VARCHAR(191) NULL,
    `email` VARCHAR(191) NOT NULL,
    `password` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,
    `rolesId` VARCHAR(191) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Stocks` (
    `id` VARCHAR(191) NOT NULL,
    `quantity` INTEGER NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,
    `productsId` VARCHAR(191) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ListBill` (
    `id` VARCHAR(191) NOT NULL,
    `idBill` VARCHAR(191) NOT NULL,
    `totalQty` INTEGER NOT NULL,
    `totalItems` INTEGER NOT NULL,
    `totalPrice` DOUBLE NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,
    `usersId` VARCHAR(191) NULL,
    `billTypesId` VARCHAR(191) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `BillTypes` (
    `id` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `Profiles` ADD CONSTRAINT `Profiles_usersId_fkey` FOREIGN KEY (`usersId`) REFERENCES `Users`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Employees` ADD CONSTRAINT `Employees_rolesId_fkey` FOREIGN KEY (`rolesId`) REFERENCES `Roles`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Outlets` ADD CONSTRAINT `Outlets_usersId_fkey` FOREIGN KEY (`usersId`) REFERENCES `Users`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Categories` ADD CONSTRAINT `Categories_outletsId_fkey` FOREIGN KEY (`outletsId`) REFERENCES `Outlets`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Products` ADD CONSTRAINT `Products_categoriesId_fkey` FOREIGN KEY (`categoriesId`) REFERENCES `Categories`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Stocks` ADD CONSTRAINT `Stocks_productsId_fkey` FOREIGN KEY (`productsId`) REFERENCES `Products`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ListBill` ADD CONSTRAINT `ListBill_usersId_fkey` FOREIGN KEY (`usersId`) REFERENCES `Users`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ListBill` ADD CONSTRAINT `ListBill_billTypesId_fkey` FOREIGN KEY (`billTypesId`) REFERENCES `BillTypes`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Bills` ADD CONSTRAINT `Bills_productsId_fkey` FOREIGN KEY (`productsId`) REFERENCES `Products`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Bills` ADD CONSTRAINT `Bills_listBillId_fkey` FOREIGN KEY (`listBillId`) REFERENCES `ListBill`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;
