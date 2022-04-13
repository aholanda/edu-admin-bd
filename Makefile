CSS := texinfo.css
TEXI := $(wildcard *.texi)

all: index.html main.pdf slides.pdf

index.html: main.texi $(TEXI) $(CSS)
	texi2any --css-ref=$(CSS) --html --no-split $< -o $@
trash += index.html

main.pdf: main.texi $(TEXI)
	texi2any --pdf $< -o $@
trash += main.pdf

slides.pdf: slides.tex
	xelatex $<

clean:
	$(RM) $(trash) *.aux *.log *.nav *.out *.pdf *.snm *.toc *.vrb

