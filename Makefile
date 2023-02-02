ROBOT=robot

cl.owl:
	wget -O $@ http://purl.obolibrary.org/obo/cl/cl.owl

kidney-view.owl: cl.owl seed.txt
	# java -jar robot.jar extract --method subset --input $< --term-file seed.txt --intermediates minimal --output $@
	$(ROBOT) reason --input $< --reasoner ELK \
		relax \
		filter --term-file seed.txt --select "annotations anonymous self" --trim true --signature true \
		reduce --output $@.tmp.owl && mv $@.tmp.owl $@

kidney-view.json: kidney-view.owl
	$(ROBOT) convert --input $< --format json -o $@
