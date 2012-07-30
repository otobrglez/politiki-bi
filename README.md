# Politiki BI 

This project provides API for collection and aggregation of measurements made by politiki-ecosystem. Project provide simple MDX API endpoint with Grape and also provides RabbitMQ "worker" for filling the OLAP cube.

## Using MDX from rake task

    cat spec/mdx/002* | RACK_ENV=test rake mdx

## Resources

* [Politiki](http://politiki.si)
* [Mondrian OLAP](https://github.com/rsim/mondrian-olap)
* [Grape](https://github.com/intridea/grape/)

## Author 

* Oto Brglez - <oto.brglez@opalab.com>