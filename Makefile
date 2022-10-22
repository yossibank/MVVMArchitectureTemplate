PRODUCT_NAME := MVVMArchitectureTemplate

.PHONY: setup
setup:
	$(MAKE) install-mint-packages
	$(MAKE) generate-xcodeproj
	$(MAKE) open

.PHONY: install-mint-packages
install-mint-packages:
	mint bootstrap --overwrite y

.PHONY: generate-xcodeproj
generate-xcodeproj:
	mint run xcodegen

.PHONY: open
open:
	open ./$(PRODUCT_NAME).xcodeproj