/*
  Warnings:

  - The primary key for the `Livros` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `id` on the `Livros` table. All the data in the column will be lost.
  - Added the required column `idLivro` to the `Livros` table without a default value. This is not possible if the table is not empty.

*/
-- CreateTable
CREATE TABLE "Usuarios" (
    "idUser" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "nome" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "senha" TEXT NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL
);

-- CreateTable
CREATE TABLE "Emprestimos" (
    "idEmprestimo" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "livroId" INTEGER NOT NULL,
    "usuarioId" INTEGER NOT NULL,
    "emprestado" DATETIME NOT NULL,
    "devolvido" DATETIME,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    CONSTRAINT "Emprestimos_livroId_fkey" FOREIGN KEY ("livroId") REFERENCES "Livros" ("idLivro") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Emprestimos_usuarioId_fkey" FOREIGN KEY ("usuarioId") REFERENCES "Usuarios" ("idUser") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Livros" (
    "idLivro" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "titulo" TEXT NOT NULL,
    "autor" TEXT NOT NULL,
    "publicado" DATETIME NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL
);
INSERT INTO "new_Livros" ("autor", "createdAt", "publicado", "titulo", "updatedAt") SELECT "autor", "createdAt", "publicado", "titulo", "updatedAt" FROM "Livros";
DROP TABLE "Livros";
ALTER TABLE "new_Livros" RENAME TO "Livros";
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;

-- CreateIndex
CREATE UNIQUE INDEX "Usuarios_email_key" ON "Usuarios"("email");
