.DEFAULT_GOAL := help

PROJECT := App/Tikilive.xcodeproj

.PHONY: help bootstrap project build build-tvos build-release clean

help: ## list available commands
	@grep -E "^[a-z-]+:.*##" $(MAKEFILE_LIST) | sed "s/:.*## /\t/"

bootstrap: ## install required tools at their pinned versions
	brew install mint
	mint bootstrap

# NOTE: run from the repo root - Mint only looks for Mintfile in the current directory
project: ## generate and open the Xcode project
	mint run xcodegen generate --spec App/project.yml
	open $(PROJECT)

build: ## build the iOS app
	xcodebuild -project $(PROJECT) -scheme Tikilive-iOS -destination "generic/platform=iOS Simulator" build

build-tvos: ## build the tvOS app
	xcodebuild -project $(PROJECT) -scheme Tikilive-tvOS -destination "generic/platform=tvOS Simulator" build

build-release: ## build the iOS app in Release - check before archiving
	xcodebuild -project $(PROJECT) -scheme Tikilive-iOS -configuration Release -destination "generic/platform=iOS Simulator" build

clean: ## remove the generated project
	rm -rf $(PROJECT)
