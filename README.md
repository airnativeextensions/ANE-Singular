built by [distriqt //](https://airnativeextensions.com) 

![](images/hero.png)

# Singular

The [Singular](https://docs.airnativeextensions.com/docs/singular) extension gives you access to the [Singular SDK](https://www.singular.net/) for anayltics. 

We provide complete guides to get you up and running with sharing quickly and easily.


### Features

- Access the Singular SDK - https://www.singular.net/
- Single API interface - your code works across iOS and Android with no modifications
- Sample project code and ASDocs reference

As with all our extensions you get access to a year of support and updates as we are 
continually improving and updating the extensions for OS updates and feature requests.



## Documentation

The [documentation site](https://docs.airnativeextensions.com/docs/singular) forms the best source of detailed documentation for the extension along with the [asdocs](https://docs.airnativeextensions.com/asdocs/singular). 

Quick Example: 

```actionscript
Singular.instance.init( 
    new SingularConfig( API_KEY, SECRET )
 );
```

```actionscript 
Singular.instance.event( SingularEvents.SUBSCRIBE );
```

```actionscript
Singular.instance.event(
            "bonus_points_earned",
            {
                "points": 500
            }
    );
```

More information here: 

[com.singular](https://docs.airnativeextensions.com/docs/singular)


## License

You can purchase a license for using this extension:

- [airnativeextensions.com](https://airnativeextensions.com/)


distriqt retains all copyright.


![](images/promo.png)