/*
  Warnings:

  - You are about to drop the column `usersId` on the `Roles` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE `Roles` DROP FOREIGN KEY `Roles_usersId_fkey`;

-- AlterTable
ALTER TABLE `Roles` DROP COLUMN `usersId`;

-- AlterTable
ALTER TABLE `Users` ADD COLUMN `rolesId` VARCHAR(191) NULL;

-- AddForeignKey
ALTER TABLE `Users` ADD CONSTRAINT `Users_rolesId_fkey` FOREIGN KEY (`rolesId`) REFERENCES `Roles`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;
