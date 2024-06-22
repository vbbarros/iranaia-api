-- CreateEnum
CREATE TYPE "Sexo" AS ENUM ('M', 'F');

-- CreateEnum
CREATE TYPE "EstadoAnimalEnum" AS ENUM ('PARIDA_LACTACAO', 'PARIDA_LACTACAO_PRENHA', 'PRENHA_SECA', 'SECA_NAO_PRENHA');

-- CreateEnum
CREATE TYPE "ProtocoloSanitarioEnum" AS ENUM ('VACINA', 'VERMIFUGO', 'CARRAPATICIDA', 'BRINCO_MOSCA');

-- CreateTable
CREATE TABLE "StatusAnimal" (
    "id" TEXT NOT NULL,
    "descricao" TEXT NOT NULL,

    CONSTRAINT "StatusAnimal_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Animal" (
    "id" TEXT NOT NULL,
    "numeroBrinco" TEXT NOT NULL,
    "sexo" "Sexo" NOT NULL,
    "dataNascimento" TIMESTAMP(3) NOT NULL,
    "foto" TEXT,
    "raca" TEXT NOT NULL,
    "descricao" TEXT NOT NULL,
    "preco" DECIMAL(10,2) NOT NULL,
    "maeId" TEXT,
    "fazendaId" TEXT NOT NULL,
    "statusAnimalId" TEXT NOT NULL,

    CONSTRAINT "Animal_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TipoHistoricoFemea" (
    "id" TEXT NOT NULL,
    "descricao" TEXT NOT NULL,

    CONSTRAINT "TipoHistoricoFemea_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "HistoricoFemea" (
    "id" TEXT NOT NULL,
    "data" TIMESTAMP(3) NOT NULL,
    "descricao" TEXT NOT NULL,
    "animalId" TEXT NOT NULL,
    "tipoHistoricoFemeaId" TEXT NOT NULL,

    CONSTRAINT "HistoricoFemea_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ProducaoLeite" (
    "id" TEXT NOT NULL,
    "data" TIMESTAMP(3) NOT NULL,
    "quantidade" DECIMAL(10,2) NOT NULL,
    "animalId" TEXT NOT NULL,

    CONSTRAINT "ProducaoLeite_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TipoEstoque" (
    "id" TEXT NOT NULL,
    "descricao" TEXT NOT NULL,

    CONSTRAINT "TipoEstoque_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ItemEstoque" (
    "id" TEXT NOT NULL,
    "nome" TEXT NOT NULL,
    "descricao" TEXT NOT NULL,
    "tipoEstoqueId" TEXT NOT NULL,

    CONSTRAINT "ItemEstoque_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Estoque" (
    "id" TEXT NOT NULL,
    "quantidade" INTEGER NOT NULL,
    "preco" DECIMAL(10,2) NOT NULL,
    "itemEstoqueId" TEXT NOT NULL,
    "fazendaId" TEXT NOT NULL,

    CONSTRAINT "Estoque_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SaidaEstoque" (
    "id" TEXT NOT NULL,
    "quantidade" INTEGER NOT NULL,
    "dataSaida" TIMESTAMP(3) NOT NULL,
    "motivo" TEXT NOT NULL,
    "responsavel" TEXT NOT NULL,
    "estoqueId" TEXT NOT NULL,

    CONSTRAINT "SaidaEstoque_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "HistoricoPrecoLeite" (
    "id" TEXT NOT NULL,
    "data" TIMESTAMP(3) NOT NULL,
    "preco" DECIMAL(10,2) NOT NULL,
    "fazendaId" TEXT NOT NULL,

    CONSTRAINT "HistoricoPrecoLeite_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "VendaAnimal" (
    "id" TEXT NOT NULL,
    "dataVenda" TIMESTAMP(3) NOT NULL,
    "preco" DECIMAL(10,2) NOT NULL,
    "animalId" TEXT NOT NULL,

    CONSTRAINT "VendaAnimal_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "EstadoAnimal" (
    "id" TEXT NOT NULL,
    "estado" "EstadoAnimalEnum" NOT NULL,
    "dataInicio" TIMESTAMP(3) NOT NULL,
    "dataFim" TIMESTAMP(3) NOT NULL,
    "animalId" TEXT NOT NULL,

    CONSTRAINT "EstadoAnimal_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "StatusBezerro" (
    "id" TEXT NOT NULL,
    "descricao" TEXT NOT NULL,

    CONSTRAINT "StatusBezerro_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Bezerro" (
    "id" TEXT NOT NULL,
    "dataNascimento" TIMESTAMP(3) NOT NULL,
    "sexo" "Sexo" NOT NULL,
    "dataVenda" TIMESTAMP(3) NOT NULL,
    "preco" DECIMAL(10,2) NOT NULL,
    "statusBezerroId" TEXT NOT NULL,
    "maeId" TEXT NOT NULL,

    CONSTRAINT "Bezerro_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ProtocoloSanitario" (
    "id" TEXT NOT NULL,
    "tipo" "ProtocoloSanitarioEnum" NOT NULL,
    "data" TIMESTAMP(3) NOT NULL,
    "descricao" TEXT NOT NULL,
    "animalId" TEXT NOT NULL,

    CONSTRAINT "ProtocoloSanitario_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "VendaLeite" (
    "id" TEXT NOT NULL,
    "data" TIMESTAMP(3) NOT NULL,
    "quantidadeLitros" DECIMAL(10,2) NOT NULL,
    "fotoComprovante" TEXT NOT NULL,
    "descricao" TEXT NOT NULL,
    "preco" DECIMAL(10,2) NOT NULL,
    "fazendaId" TEXT,

    CONSTRAINT "VendaLeite_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CompraAnimal" (
    "id" TEXT NOT NULL,
    "dataPagamento" TIMESTAMP(3) NOT NULL,
    "preco" DECIMAL(10,2) NOT NULL,
    "nomeVendedor" TEXT NOT NULL,
    "descricao" TEXT NOT NULL,
    "animalId" TEXT NOT NULL,

    CONSTRAINT "CompraAnimal_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "CompraAnimal_animalId_key" ON "CompraAnimal"("animalId");

-- AddForeignKey
ALTER TABLE "Animal" ADD CONSTRAINT "Animal_fazendaId_fkey" FOREIGN KEY ("fazendaId") REFERENCES "Fazenda"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Animal" ADD CONSTRAINT "Animal_statusAnimalId_fkey" FOREIGN KEY ("statusAnimalId") REFERENCES "StatusAnimal"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Animal" ADD CONSTRAINT "Animal_maeId_fkey" FOREIGN KEY ("maeId") REFERENCES "Animal"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "HistoricoFemea" ADD CONSTRAINT "HistoricoFemea_animalId_fkey" FOREIGN KEY ("animalId") REFERENCES "Animal"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "HistoricoFemea" ADD CONSTRAINT "HistoricoFemea_tipoHistoricoFemeaId_fkey" FOREIGN KEY ("tipoHistoricoFemeaId") REFERENCES "TipoHistoricoFemea"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProducaoLeite" ADD CONSTRAINT "ProducaoLeite_animalId_fkey" FOREIGN KEY ("animalId") REFERENCES "Animal"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ItemEstoque" ADD CONSTRAINT "ItemEstoque_tipoEstoqueId_fkey" FOREIGN KEY ("tipoEstoqueId") REFERENCES "TipoEstoque"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Estoque" ADD CONSTRAINT "Estoque_itemEstoqueId_fkey" FOREIGN KEY ("itemEstoqueId") REFERENCES "ItemEstoque"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Estoque" ADD CONSTRAINT "Estoque_fazendaId_fkey" FOREIGN KEY ("fazendaId") REFERENCES "Fazenda"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SaidaEstoque" ADD CONSTRAINT "SaidaEstoque_estoqueId_fkey" FOREIGN KEY ("estoqueId") REFERENCES "Estoque"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "HistoricoPrecoLeite" ADD CONSTRAINT "HistoricoPrecoLeite_fazendaId_fkey" FOREIGN KEY ("fazendaId") REFERENCES "Fazenda"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "VendaAnimal" ADD CONSTRAINT "VendaAnimal_animalId_fkey" FOREIGN KEY ("animalId") REFERENCES "Animal"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "EstadoAnimal" ADD CONSTRAINT "EstadoAnimal_animalId_fkey" FOREIGN KEY ("animalId") REFERENCES "Animal"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Bezerro" ADD CONSTRAINT "Bezerro_statusBezerroId_fkey" FOREIGN KEY ("statusBezerroId") REFERENCES "StatusBezerro"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Bezerro" ADD CONSTRAINT "Bezerro_maeId_fkey" FOREIGN KEY ("maeId") REFERENCES "Animal"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProtocoloSanitario" ADD CONSTRAINT "ProtocoloSanitario_animalId_fkey" FOREIGN KEY ("animalId") REFERENCES "Animal"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "VendaLeite" ADD CONSTRAINT "VendaLeite_fazendaId_fkey" FOREIGN KEY ("fazendaId") REFERENCES "Fazenda"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CompraAnimal" ADD CONSTRAINT "CompraAnimal_animalId_fkey" FOREIGN KEY ("animalId") REFERENCES "Animal"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
