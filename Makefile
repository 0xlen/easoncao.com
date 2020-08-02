default:
	docker run -p 4000:4000 --volume="$$PWD:/srv/jekyll" -it -e VERBOSE="" -e JEKYLL_DEBUG="" jekyll/jekyll:3.8.6 jekyll serve -V --watch --force_polling
