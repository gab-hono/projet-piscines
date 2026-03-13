-- CreateEnum
CREATE TYPE "Role" AS ENUM ('USER', 'ADMIN');

-- CreateTable
CREATE TABLE "Utilisateur" (
    "id" SERIAL NOT NULL,
    "nom_prenom" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "mot_de_passe" TEXT NOT NULL,
    "pronoms" TEXT,
    "photo" TEXT,
    "role" "Role" NOT NULL DEFAULT 'USER',
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Utilisateur_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Piscine" (
    "id" SERIAL NOT NULL,
    "nom" TEXT NOT NULL,
    "adresse" TEXT NOT NULL,
    "description" TEXT,
    "acces_pmr" BOOLEAN NOT NULL DEFAULT false,
    "queer_friendly" BOOLEAN NOT NULL DEFAULT false,
    "accepte_passe_paris" BOOLEAN NOT NULL DEFAULT true,
    "is_open" BOOLEAN NOT NULL DEFAULT true,
    "last_updated_at" TIMESTAMP(3) NOT NULL,
    "images_galerie" TEXT[],
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Piscine_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Bassin" (
    "id" SERIAL NOT NULL,
    "longueur" DOUBLE PRECISION,
    "profondeur" DOUBLE PRECISION,
    "piscineId" INTEGER NOT NULL,

    CONSTRAINT "Bassin_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Horaire" (
    "id" SERIAL NOT NULL,
    "jour" TEXT NOT NULL,
    "heure_ouverture" TEXT NOT NULL,
    "heure_fermeture" TEXT NOT NULL,
    "piscineId" INTEGER NOT NULL,

    CONSTRAINT "Horaire_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Favori" (
    "id" SERIAL NOT NULL,
    "utilisateurId" INTEGER NOT NULL,
    "piscineId" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Favori_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Avis" (
    "id" SERIAL NOT NULL,
    "note_accessibilite" INTEGER NOT NULL,
    "commentaire_accessibilite" TEXT NOT NULL,
    "note_accueil" INTEGER NOT NULL,
    "commentaire_accueil" TEXT NOT NULL,
    "note_bassin" INTEGER NOT NULL,
    "commentaire_bassin" TEXT NOT NULL,
    "note_vestiaires" INTEGER NOT NULL,
    "commentaire_vestiaires" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "utilisateurId" INTEGER NOT NULL,
    "piscineId" INTEGER NOT NULL,

    CONSTRAINT "Avis_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Utilisateur_email_key" ON "Utilisateur"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Favori_utilisateurId_piscineId_key" ON "Favori"("utilisateurId", "piscineId");

-- CreateIndex
CREATE UNIQUE INDEX "Avis_utilisateurId_piscineId_key" ON "Avis"("utilisateurId", "piscineId");

-- AddForeignKey
ALTER TABLE "Bassin" ADD CONSTRAINT "Bassin_piscineId_fkey" FOREIGN KEY ("piscineId") REFERENCES "Piscine"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Horaire" ADD CONSTRAINT "Horaire_piscineId_fkey" FOREIGN KEY ("piscineId") REFERENCES "Piscine"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Favori" ADD CONSTRAINT "Favori_utilisateurId_fkey" FOREIGN KEY ("utilisateurId") REFERENCES "Utilisateur"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Favori" ADD CONSTRAINT "Favori_piscineId_fkey" FOREIGN KEY ("piscineId") REFERENCES "Piscine"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Avis" ADD CONSTRAINT "Avis_utilisateurId_fkey" FOREIGN KEY ("utilisateurId") REFERENCES "Utilisateur"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Avis" ADD CONSTRAINT "Avis_piscineId_fkey" FOREIGN KEY ("piscineId") REFERENCES "Piscine"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
