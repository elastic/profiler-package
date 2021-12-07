.PHONY: package packages clean run-registry

INTEGRATION_PKG:=agent\
		collector

package: int_pkg=agent
package:
	cd package/$(int_pkg) && \
	elastic-package check
	

packages:
	$(foreach int_pkg,$(INTEGRATION_PKG), \
		($(MAKE) package int_pkg=$(int_pkg) ) || exit ; \
	)
clean:
	$(foreach int_pkg,$(INTEGRATION_PKG), \
		rm -rf build/integrations/profiler_$(int_pkg) \
	)

run-registry: build-packages
	docker-compose pull
	docker-compose up

