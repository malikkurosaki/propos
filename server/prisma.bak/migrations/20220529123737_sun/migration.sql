/*
  Warnings:

  - You are about to alter the column `name` on the `Products` table. The data in that column could be lost. The data in that column will be cast from `Char(255)` to `VarChar(191)`.

*/
-- DropIndex
DROP INDEX `Products_name_key` ON `Products`;

-- AlterTable
ALTER TABLE `Products` MODIFY `name` VARCHAR(191) NOT NULL;
