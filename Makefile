.PHONY: package packages clean run-registry
.DEFAULT_GOAL: packages

# 'make V=1' switches on verbose output
V ?= 0
ifeq ($(V),1)
	AT :=
	VFLAG := -v
else
	AT := @
	SFLAG := -s
endif

pkgs ?= agent collector

packages:
	$(AT)$(foreach pkg,$(pkgs), \
		$(MAKE) $(SFLAG) package pkg=$(pkg) || exit ; \
	)

clean:
	$(AT)$(foreach pkg,$(pkgs), \
		$(MAKE) $(SFLAG) clean-package pkg=$(pkg) || exit ; \
	)
	$(AT)rm -rf build/

package:
	@echo "## Build integration package $(pkg)"
	$(AT)cd package/$(pkg) && \
	elastic-package check $(VFLAG)

clean-package:
	@echo "## Clean integration package $(pkg)"
	$(AT)cd package/$(pkg) && \
	elastic-package clean $(VFLAG)

# Variables:
# $DISTRIBUTION
#   snapshot: run snapshot EPR
#   production: run production EPR (default)
run-registry: packages
	docker-compose pull
	docker-compose up
