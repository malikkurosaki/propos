/*
  Warnings:

  - You are about to drop the column `employeesId` on the `Roles` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE `Roles` DROP FOREIGN KEY `Roles_employeesId_fkey`;

-- AlterTable
ALTER TABLE `Employees` ADD COLUMN `rolesId` VARCHAR(191) NULL;

-- AlterTable
ALTER TABLE `Roles` DROP COLUMN `employeesId`;

-- AddForeignKey
ALTER TABLE `Employees` ADD CONSTRAINT `Employees_rolesId_fkey` FOREIGN KEY (`rolesId`) REFERENCES `Roles`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;
