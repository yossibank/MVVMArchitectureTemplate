PRODUCT_NAME := MVVMArchitectureTemplate

.PHONY: setup
setup:
	$(MAKE) install-bundler
	$(MAKE) install-mint-packages
	$(MAKE) generate-consts
	$(MAKE) generate-test-mock
	$(MAKE) generate-xcodeproj
	$(MAKE) open

.PHONY: install-bundler
install-bundler:
	bundle install

.PHONY: install-mint-packages
install-mint-packages:
	mint bootstrap --overwrite y

.PHONY: generate-consts
generate-consts:
	mint run swiftgen config run --config swiftgen.yml

.PHONY: generate-test-mock
generate-test-mock:
	mint run mockolo mockolo --sourcedirs ${PRODUCT_NAME} \
		--destination ${PRODUCT_NAME}Tests/Mock/MockResults.swift \
		--testable-imports ${PRODUCT_NAME} \
		--mock-final

.PHONY: generate-xcodeproj
generate-xcodeproj:
	mint run xcodegen --use-cache

.PHONY: generate-files
generate-files:
	mkdir -p MVVMArchitectureTemplate/Resources/Generated
	mkdir -p MVVMArchitectureTemplateTests/Mock

.PHONY: open
open:
	open ./$(PRODUCT_NAME).xcodeproj

.PHONY: clean
clean:
	sudo rm -rf ~/Library/Developer/Xcode/DerivedData/*
	sudo rm -rf ~/Library/Developer/Xcode/Archives/*
	sudo rm -rf ~/Library/Caches/*
	sudo rm -rf ~/Library/Logs/iOS\ Simulator
	sudo rm -rf ~/Library/Developer/Xcode/iOS\ DeviceSupport/*