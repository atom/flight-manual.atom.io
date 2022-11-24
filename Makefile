NAME      := collapsify
VERSION   := $(shell node -p "require('./package.json').version")
ITERATION := 0

TMP_ROOT             := $(shell pwd)/tmp
PACKAGE_ROOT         := $(TMP_ROOT)/packaging
INSTALL_PREFIX       := usr/local
DEB_PACKAGE          := $(TMP_ROOT)/$(NAME)_$(VERSION)-$(ITERATION)_amd64.deb

$(DEB_PACKAGE): clean
	@echo $(VERSION)
	mkdir -p $(PACKAGE_ROOT)/$(INSTALL_PREFIX)/$(NAME)

    # statics:
	cp -r -p bin                $(PACKAGE_ROOT)/$(INSTALL_PREFIX)/$(NAME)/.
	cp -r -p lib                $(PACKAGE_ROOT)/$(INSTALL_PREFIX)/$(NAME)/.
	cp -r -p index.js           $(PACKAGE_ROOT)/$(INSTALL_PREFIX)/$(NAME)/.
	cp -r -p package.json       $(PACKAGE_ROOT)/$(INSTALL_PREFIX)/$(NAME)/.
	cp -r -p package-lock.json  $(PACKAGE_ROOT)/$(INSTALL_PREFIX)/$(NAME)/.

    # add node dependcies
	cd $(PACKAGE_ROOT)/$(INSTALL_PREFIX)/$(NAME)/; npm ci

    # build deb package:
	fpm -C $(PACKAGE_ROOT) -s dir -t deb -n $(NAME) -v $(VERSION) \
        --iteration $(ITERATION) \
        --depends "nodejs" \
        --deb-user root \
        --deb-group root \
        -p $(DEB_PACKAGE)

.PHONY: cf-package
cf-package: $(DEB_PACKAGE)

.PHONY: clean-package
clean-package:
	$(RM) -r $(TMP_ROOT)

.PHONY: clean
clean: clean-package
