TEXFILE = main.tex
PDFFILE = main.pdf

BASEDIR=$(CURDIR)
OUTPUTDIR=$(BASEDIR)/output

GITHUB_PAGES_BRANCH=master

help:
	@echo 'Makefile for automatic LaTeX compilation                                  '
	@echo '                                                                          '
	@echo 'Usage:                                                                    '
	@echo '   make clean                          remove the generated files         '
	@echo '   make build	                        generate files										 '
	@echo '   make github                         upload the web site via gh-pages   '
	@echo '                                                                          '


clean:
	[ ! -d $(OUTPUTDIR) ] || rm -rf $(OUTPUTDIR)

build:
	mkdir $(OUTPUTDIR)
	sudo docker run -it -v $(BASEDIR):/var/texlive harshjv/texlive-2015 sh -c "cd src && pdflatex $(TEXFILE)"
	mv "src/$(PDFFILE)" $(OUTPUTDIR)
	#cp CNAME $(OUTPUTDIR)
	cp index.html $(OUTPUTDIR)

github:
	ghp-import -n $(OUTPUTDIR)
	@git push -fq https://${GH_TOKEN}@github.com/$(TRAVIS_REPO_SLUG).git gh-pages > /dev/null

.PHONY: help clean build github
