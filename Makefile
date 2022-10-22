PRODUCT_NAME := MVVMArchitectureTemplate

.PHONY: setup
setup:
	$(MAKE) install-mint-packages
	$(MAKE) generate-consts
	$(MAKE) generate-xcodeproj
	$(MAKE) open

.PHONY: install-mint-packages
install-mint-packages:
	mint bootstrap --overwrite y

.PHONY: generate-consts
generate-consts:
	mint run swiftgen config run --config swiftgen.yml

.PHONY: generate-xcodeproj
generate-xcodeproj:
	mint run xcodegen --use-cache

.PHONY: clean
clean:
	sudo rm -rf ~/Library/Developer/Xcode/DerivedData/*
	sudo rm -rf ~/Library/Developer/Xcode/Archives/*
	sudo rm -rf ~/Library/Caches/*
	sudo rm -rf ~/Library/Logs/iOS\ Simulator
	sudo rm -rf ~/Library/Developer/Xcode/iOS\ DeviceSupport/*

.PHONY: open
open:
	open ./$(PRODUCT_NAME).xcodeproj