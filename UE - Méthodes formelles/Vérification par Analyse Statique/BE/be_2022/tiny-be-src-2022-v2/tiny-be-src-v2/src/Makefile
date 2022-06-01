OCAMLBUILD=ocamlbuild -use-ocamlfind -classic-display -no-links
LOCAL_DOCDIR=doc

tiny:
	$(OCAMLBUILD) main.native
	cp _build/main.native tiny

dep:
	opam install zarith
doc:
	$(OCAMLBUILD) tiny.docdir/index.html
	rm -rf $(LOCAL_DOCDIR)
	cp -rf _build/tiny.docdir $(LOCAL_DOCDIR)

clean:
	$(OCAMLBUILD) -clean
	rm -f *~ domains/*~

.PHONY: tiny doc clean dep
