SRC=$(wildcard *.ml *.mll)

.SUFFIXES:
.PHONY: clean

main.native: $(SRC)
	ocamlbuild -verbose 0 -pp camlp4o $@

clean:
	ocamlbuild -clean
