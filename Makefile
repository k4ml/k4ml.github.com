
PELICAN=pelican
PELICANOPTS=None

BASEDIR=$(PWD)
INPUTDIR=$(BASEDIR)/src
OUTPUTDIR=$(BASEDIR)
CONFFILE=$(BASEDIR)/pelican.conf.py

FTP_HOST=localhost
FTP_USER=anonymous
FTP_TARGET_DIR=/

SSH_HOST=localhost
SSH_USER=k4ml
SSH_TARGET_DIR=/var/www

DROPBOX_DIR=~/Dropbox/Public/

help:
	@echo 'Makefile for a pelican Web site                                       '
	@echo '                                                                      '
	@echo 'Usage:                                                                '
	@echo '   make html                        (re)generate the web site         '
	@echo '   make clean                       remove the generated files        '
	@echo '   ftp_upload                       upload the web site using FTP     '
	@echo '   ssh_upload                       upload the web site using SSH     '
	@echo '   dropbox_upload                   upload the web site using Dropbox '
	@echo '                                                                      '


html:
	$(PELICAN) $(INPUTDIR) -o $(OUTPUTDIR) -s $(CONFFILE)

clean:
	rm -fr $(OUTPUTDIR)
	mkdir $(OUTPUTDIR)

dropbox_upload: $(OUTPUTDIR)/index.html
	cp -r $(OUTPUTDIR)/* $(DROPBOX_DIR)

ssh_upload: $(OUTPUTDIR)/index.html
	scp -r $(OUTPUTDIR)/* $(SSH_USER)@$(SSH_HOST):$(SSH_TARGET_DIR)

ftp_upload: $(OUTPUTDIR)/index.html
	lftp ftp://$(FTP_USER)@$(FTP_HOST) -e "mirror -R $(OUTPUT_DIR)/* $(FTP_TARGET_DIR) ; quit"

github: $(OUTPUTDIR)/index.html
	git status | grep -v "Your branch is ahead of" || (echo 'Push first' && exit 1)
	ghp-import $(OUTPUTDIR)
	git push origin gh-pages

serve:
	python -m 'SimpleHTTPServer'

.PHONY: html help clean ftp_upload ssh_upload dropbox_upload github
    
