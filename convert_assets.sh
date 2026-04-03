# Chemins (Relatifs pour la portabilité)
WIMGT   := ./tools/wimgt/wimgt.exe
IN_DIR  := ./tools/wimgt/in

convert:
	@echo "--- Conversion des PNG en TPL ---"
	@chmod +x $(WIMGT)
	
	@echo "Conversion du fond (WiiUBOOT)..."
	$(WIMGT) COPY $(IN_DIR)/boot_bg.png $(IN_DIR)/boot_bg.tpl --transform CMPR --overwrite
	
	@echo "Conversion de la roue (loading_wheel)..."
	$(WIMGT) COPY $(IN_DIR)/loading_wheel.png $(IN_DIR)/loading_wheel.tpl --transform RGBA8 --overwrite
	
	@echo "--- Terminé ! ---"