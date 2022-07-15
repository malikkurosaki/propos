/*
  Warnings:

  - A unique constraint covering the columns `[pin]` on the table `Employees` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `pin` to the `Employees` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `Employees` ADD COLUMN `pin` VARCHAR(191) NOT NULL;

-- CreateIndex
CREATE UNIQUE INDEX `Employees_pin_key` ON `Employees`(`pin`);
