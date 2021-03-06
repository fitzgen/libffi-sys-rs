default: build
hard: test

CRATE = libffi_sys
REPO  = libffi-sys-rs

build:
	clear
	cargo build
	make doc

doc:
	cargo doc --no-deps
	echo "<meta http-equiv='refresh' content='0;url=$(CRATE)/'>" \
		> target/doc/index.html

test:
	clear
	cargo test

upload-doc:
	make doc
	ghp-import -n target/doc
	git push -f https://github.com/tov/$(REPO).git gh-pages

release:
	bin/prepare_release.sh $(VERSION)
	make upload-doc
	cargo publish

clean:
	cargo clean
	$(RM) src/raw.rs
