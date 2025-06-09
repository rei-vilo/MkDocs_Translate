# Create virtual environment
# python -m venv ~/.venvs/mkdocs
# Install 
# make update
# git clone https://github.com/flynneva/mkdocs-custom-superfence-example
# cd mkdocs-custom-superfence-example
# ~/.venvs/mkdocs/bin/python -m pip install .

# Compare ./theme/base.html
# with $(HOME)/.venvs/mkdocs/lib/python3.11/site-packages/material/base.html

# $(info $(shell echo $$HOME))
# $(info HOME $(HOME))
# $(error STOP)

$(info "=== Clean .cache")
# $(shell if [ -d .cache ] ; then rm -rf .cache ; fi)
# Keep the fonts!
$(shell if [ -d .cache/plugin/social/ ] ; then rm .cache/plugin/social/*.png ; fi)


PATH_VENV = $(HOME)/.venvs/mkdocs/bin
PYTHON_VENV = $(PATH_VENV)/python

$(info "--- Summary")

READ_ME_FILE := Summary.md
PROJECT_NAME = $(shell basename $(shell pwd))
$(info "=== Project Name: $(PROJECT_NAME)")

$(shell echo "# Project $(PROJECT_NAME)" > $(READ_ME_FILE))

$(shell echo "  " >> $(READ_ME_FILE))
$(shell echo "## Target" >> $(READ_ME_FILE))

$(shell echo "  " >> $(READ_ME_FILE))
$(shell echo "**Date Time**         $(shell date '+%F %T')" >> $(READ_ME_FILE))

$(shell echo "  " >> $(READ_ME_FILE))
$(shell echo "**Target**            $(MAKECMDGOALS)" >> $(READ_ME_FILE))

$(shell echo "  " >> $(READ_ME_FILE))
$(shell echo "**Python**            $(shell $(PYTHON_VENV) --version | cut -d\  -f2)" >> $(READ_ME_FILE))

$(shell echo "  " >> $(READ_ME_FILE))
$(shell echo "## Packages" >> $(READ_ME_FILE))

$(shell echo "  " >> $(READ_ME_FILE))
$(shell $(PYTHON_VENV) -m pip list >> $(READ_ME_FILE))

$(shell echo "  " >> $(READ_ME_FILE))
$(shell echo "### GitHub / Azure DevOps" >> $(READ_ME_FILE) )

ifneq ($(wildcard .git/*),)
    $(shell echo "  " >> $(READ_ME_FILE))
    $(shell echo "**Commit**        $$(git log -1 | tail -1)" >> $(READ_ME_FILE))
    $(shell echo "  " >> $(READ_ME_FILE))
    $(shell echo "**Branch**            $$(git branch | grep \* | cut -d ' ' -f2)" >> $(READ_ME_FILE))
else
    $(shell echo "  " >> $(READ_ME_FILE))
    $(shell echo "None" >> $(READ_ME_FILE))
endif # wildcard .git/

$(shell echo "  " >> $(READ_ME_FILE))

# $(shell export WAYLAND_DISPLAY='wayland-0' DISPLAY=':0')
# $(shell env > make.log)

all:
	@echo "=== Build MkDocs"
	$(PYTHON_VENV) $(PATH_VENV)/mkdocs build
#	$(HOME)/.local/bin/mkdocs build
#	bash /Users/ReiVilo/Documents/emCode/MkDocs/MkDocs/do_build.sh
#   python -m mkdocs build # Windows
	@echo "=== Build done"

build: all

serve:
	@echo "=== Serve MkDocs"
#	open http://127.0.0.1:8000
	firefox http://127.0.0.1:8000 &
# Slow but clean
#	$(PATH_VENV)/python $(PATH_VENV)/mkdocs serve
# Faster but not clean
	$(PYTHON_VENV) $(PATH_VENV)/mkdocs serve --dirtyreload
#	bash /Users/ReiVilo/Documents/emCode/MkDocs/MkDocs/do_serve.sh
#   python -m mkdocs serve # Windows
#	$(HOME)/.local/bin/mkdocs serve
	@echo "=== Serve done"

github:
	@echo "=== Generate GitHub MkDocs"

	$(PYTHON_VENV) $(PATH_VENV)/mkdocs gh-deploy
	@echo "=== Generate GitHub done"

FILE1=$(shell pwd)/theme/base.html
FILE2=$(HOME)/.venvs/mkdocs/lib/python3.11/site-packages/material/templates/base.html
MELD=meld
# MELD=/usr/bin/flatpak run --branch=stable --arch=x86_64 --command=meld --file-forwarding org.gnome.meld

update:
	echo "=== Update MkDocs"
	mkdir -p $(HOME)/.venvs
	python3 -m venv $(HOME)/.venvs/mkdocs
	$(PYTHON_VENV) -m pip install --upgrade --upgrade-strategy only-if-needed mkdocs mkdocs-material mkdocs-plugin-progress mkdocs-htmlproofer-plugin mkdocs-macros-plugin mkdocs-glightbox mkdocs-git-revision-date-localized-plugin pymdown-extensions "mkdocs-material[imaging]" lxml mkdocs-page-pdf
#	/usr/local/bin/pip install --user --upgrade --upgrade-strategy only-if-needed mkdocs
#	/usr/local/bin/pip install --user --upgrade --upgrade-strategy only-if-needed mkdocs-material
#	pip install --upgrade --upgrade-strategy only-if-needed mkdocs mkdocs-material mkdocs-plugin-progress mkdocs-htmlproofer-plugin mkdocs-macros-plugin
# 	pip install --upgrade --upgrade-strategy only-if-needed mkdocs-material
# 	pip install --upgrade --upgrade-strategy only-if-needed mkdocs-plugin-progress
# 	pip install --upgrade --upgrade-strategy only-if-needed mkdocs-htmlproofer-plugin
# 	pip install --upgrade --upgrade-strategy only-if-needed mkdocs-macros-plugin
#
#	@echo "Compare ./theme/base.html"
#	@echo "with $(HOME)/.venvs/mkdocs/lib/python3.11/site-packages/material/base.html"
	@if [ -f "$(FILE1)" ]; then echo . ; echo "Compare $(FILE1)" ; echo "with $(FILE2)" ; $(MELD) "$(FILE1)" "$(FILE2)" ; fi

	@echo "=== Update done"

.PHONY: all, serve, update
