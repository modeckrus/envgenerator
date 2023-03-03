.PHONY : env
env_dev:
	dart pub global activate envgenerator
	dart pub global run envgenerator ./dev.json
env_prod:
	dart pub global activate envgenerator
	dart pub global run envgenerator ./prod.json
