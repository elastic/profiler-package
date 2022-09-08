.PHONY: package clean run-registry
.DEFAULT_GOAL: package

# 'make V=1' switches on verbose output
V ?= 0
ifeq ($(V),1)
	AT :=
	VFLAG := -v
else
	AT := @
	SFLAG := -s
endif

pkg ?= agent

package:
	@echo "## Build integration package $(pkg)"
	$(AT)cd package/$(pkg) && \
	elastic-package check $(VFLAG)

clean:
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
