# Introductory Database Administration course.
(content in brazilian portuguese)

This repository contains a introducttory course in database
administration. The course was planned for
[PostgreSQL](https://www.postgresql.org/) database and the scripts are
in [PL/pgSQL](https://www.postgresql.org/docs/9.6/plpgsql.html)
procedural
language. [Texinfo](https://www.postgresql.org/docs/9.6/plpgsql.html)
must be installed in order to generate `index.html`
guide. Texinfo and LaTeX must be installed to generate the same
guide in `.pdf` format. Just execute

````
make
````

Indeed, a file named [`slides.pdf`](slides.tex) is created, containing the
information about PostgreSQL architecture. To remove the
created files, execute

````
make clean
````

[exam](_exam) is a directory containing a set of exercises to
 test the skills acquired during the course.
