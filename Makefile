export

DITA_OT_VERSION  = 3.0.4
DITA_OT_DIR      = dita-ot-$(DITA_OT_VERSION)
DITA_OT_ZIP      = $(DITA_OT_DIR).zip
DITA_OT_URL = https://github.com/dita-ot/dita-ot/releases/download/$(DITA_OT_VERSION)/$(DITA_OT_ZIP)

LWDITA_VERSION = 2.0.2
LWDITA_DIR = $(DITA_OT_DIR)/plugins/org.lwdita
LWDITA_ZIP = org.lwdita-$(LWDITA_VERSION).zip
LWDITA_URL = https://github.com/jelovirt/org.lwdita/releases/download/$(LWDITA_VERSION)/$(LWDITA_ZIP)

PATH := $(PWD)/$(DITA_OT_DIR):$(PATH)
DITA = dita

TOPICMAP = $(PWD)/topicmap.tpl.xml

# Folder containing DOC.md
IN =

# Folder to put OUTPUT in. Default: '$(IN)/out'
OUT = $(IN)/out

# BEGIN-EVAL makefile-parser --make-help Makefile

help:
	@echo ""
	@echo "  Targets"
	@echo ""
	@echo "    download  Download DITA-OT dist"
	@echo "    plugins   Install DITA-OT plugins"
	@echo "    build     Build docs from $(IN)/DOC.md to $(OUT)"
	@echo ""
	@echo "  Variables"
	@echo ""
	@echo "    IN   Folder containing DOC.md"
	@echo "    OUT  Folder to put OUTPUT in. Default: '$(IN)/out'"

# END-EVAL

# Download DITA-OT dist
download: $(DITA_OT_DIR)

$(DITA_OT_DIR):
	wget "$(DITA_OT_URL)"
	unzip $(DITA_OT_ZIP)

# Install DITA-OT plugins
plugins: $(LWDITA_DIR)

$(LWDITA_DIR):
	wget $(LWDITA_URL)
	dita -d -install $(LWDITA_ZIP)

# Build docs from $(IN)/DOC.md to $(OUT)
build:
	@if test -z "$(IN)";then echo "Must set 'IN' variable to folder containing DOC.md"; exit 1; fi
	@if test -z "$(OUT)";then echo "Must set 'OUT' variable to output folder"; exit 1; fi
	-ln -s $(TOPICMAP) $(IN)/topicmap.xml
	$(DITA) -o "$(OUT)" -i "$(IN)/topicmap.xml" -f html5
	$(DITA) -o "$(OUT)" -i "$(IN)/topicmap.xml" -f pdf
	rm $(IN)/topicmap.xml
