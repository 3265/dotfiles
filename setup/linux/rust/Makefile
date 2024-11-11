.PHONY: rust
.ONESHELL:
rust:
	set -e
	bash rustup.sh
	bash lsd.sh

.PHONY: after_setup
.ONESHELL:
after_setup:
	set -e

	bash mdbook.sh
	bash fastmod.sh
