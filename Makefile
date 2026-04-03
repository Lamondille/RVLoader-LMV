.SUFFIXES:
#---------------------------------------------------------------------------------
ifeq ($(strip $(DEVKITPPC)),)
$(error "Please set DEVKITPPC in your environment. export DEVKITPPC=<path to>devkitPPC")
endif

SUBPROJECTS := dolbooter bootloader installer discloader codehandler libGUI main rvlbooter copy
.PHONY: all forced clean $(SUBPROJECTS)

all: rvlbooter
forced: clean all



dolbooter:
	@echo " "
	@echo "Building RVLoader dolbooter"
	@echo " "
	$(MAKE) -C dolbooter

bootloader: dolbooter
	@echo " "
	@echo "Building RVLoader bootloader"
	@echo " "
	$(MAKE) -C bootloader

installer: bootloader
	@echo " "
	@echo "Building RVLoader installer"
	@echo " "
	$(MAKE) -C installer

discloader:
	@echo " "
	@echo "Building RVLoader discloader"
	@echo " "
	$(MAKE) -C discloader

codehandler:
	@echo " "
	@echo "Building RVLoader codehandler"
	@echo " "
	$(MAKE) -C codehandler

libGUI:
	@echo " "
	@echo "Building RVLoader libGUI"
	@echo " "
	$(MAKE) -C libGUI install

main: dolbooter bootloader installer discloader codehandler
	@echo " "
	@echo "Building RVLoader main"
	@echo " "
	$(MAKE) -C main

rvlbooter: main
	@echo " "
	@echo "Building RVLoader rvlbooter"
	@echo " "
	$(MAKE) -C rvlbooter

#copy: main
#	@echo " "
#	@echo "Copying build to external drive"
#	@echo " "
#	@cp main/boot.dol /media/aurelio/SANDISK/apps/rvloader
#	@udisksctl unmount -b /dev/sdb
#	@udisksctl power-off -b /dev/sdb


copy: main
	@echo " "
	@echo "Recherche de la clé WII..."
	@echo " "
	$(eval DRIVE := $(shell wmic logicaldisk get deviceid,volumename | grep WII | awk '{print $$1}'))
	@if [ -z "$(DRIVE)" ]; then \
		echo "[ERREUR] Clé WII introuvable !"; \
		echo "Voici la liste de vos lecteurs détectés :"; \
		wmic logicaldisk get deviceid,volumename; \
		exit 1; \
	fi; \
	echo "[OK] Lecteur détecté : $(DRIVE)"; \
	echo "Copie du contenu de driveroot..."; \
	cp -ru driveroot/* $(DRIVE)/; \
	echo "Installation de main.dol vers /apps/RVLoader/boot.dol..."; \
	mkdir -p $(DRIVE)/apps/RVLoader; \
	cp main/main.dol $(DRIVE)/apps/RVLoader/boot.dol; \
	echo "--- TERMINE AVEC SUCCES ---"

clean:
	@echo " "
	@echo "Cleaning all subprojects..."
	@echo " "
	$(MAKE) -C dolbooter clean
	$(MAKE) -C bootloader clean
	$(MAKE) -C installer clean
	$(MAKE) -C discloader clean
	$(MAKE) -C codehandler clean
	$(MAKE) -C libGUI clean
	$(MAKE) -C main clean
	$(MAKE) -C rvlbooter clean
	rm -f $(CURDIR)/tools/wimgt/*.tpl

.PHONY: convert

# --- Chemins des outils ---
WIMGT   := ./tools/wimgt/wimgt.exe
IN_DIR  := ./tools/wimgt/in
OUT_DIR  := ./tools/wimgt/out
.PHONY: convert

convert:
	@echo "--- Conversion des PNG en TPL ---"
	@# Vérifier si l'outil existe
	@if [ ! -f $(WIMGT) ]; then echo "Erreur: wimgt.exe introuvable dans $(WIMGT)"; exit 1; fi
	@chmod +x $(WIMGT)
	
	@echo "Conversion du fond (boot_bg)..."
	@# On transforme boot_bg.png en boot_bg.tpl
	$(WIMGT) COPY $(IN_DIR)/boot_bg.png $(OUT_DIR)/boot_bg.tpl --transform CMPR --overwrite
	
	@echo "Conversion de la roue (loading_wheel)..."
	@# On transforme loading_wheel.png en loading_wheel.tpl
	$(WIMGT) COPY $(IN_DIR)/loading_wheel.png $(OUT_DIR)/loading_wheel.tpl --transform RGBA8 --overwrite
	
	@echo "--- Terminé ! Les fichiers .tpl sont dans $(OUT_DIR) ---"