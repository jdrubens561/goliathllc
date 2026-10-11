# ELEPHANT.md

- goliathconsultingllc.com already live on Squarespace 7.1. pages: /home /about /contact /services /store. /store hints Business or Commerce plan.
- site/ is the redesign: one-pager, 311 line html, 684 line css, own design tokens, mailto form, no backend. deployed on Vercel via vercel.json -> site/
- [!!] squarespace port: css has bare `body`/`a`/`img` rules and class names (.body .banner .nav .hero .field) that collide with squarespace 7.1. must scope everything under one wrapper class before paste.
- squarespace gates: custom CSS on all plans, but JS in code blocks AND code injection need Core or higher.
- jonathan asked how to port, got 3 routes + recommended hybrid (squarespace owns header/footer/form, code blocks own hero/band/offerings). offered to generate namespaced squarespace/ dir. awaiting his call.
