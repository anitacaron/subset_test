ROBOT=robot

cl.owl:
	wget -O $@ http://purl.obolibrary.org/obo/cl/cl.owl

kidney-view.owl: cl.owl seed.txt
	java -jar robot.jar extract --method subset --input $< --term-file seed.txt --intermediates minimal --output $@

kidney-view.json: kidney-view.owl
	$(ROBOT) convert --input $< --format json -o $@
