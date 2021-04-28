# Buscador MercadoLibre
iOS code challenge for MercadoLibre.

## Project structure
**BuscadorMercadoLibre target:**
Main application.
- **AdditionalFiles** group: Contains required platform files.
- **ViewControllers** group: Contains one sub group per ViewController. Each sub group has the .swift class and XIB file.
- **ViewModels** group: Contains view models.
- **Service**: Contains service classes.
- **Managers**: Contains manager classes.
- **Extensions.swift**: Contains various extensions used through the app.
- **Lumberjack.swift**: Contains structure, helper methods and global constant for logs.


**BuscadorMercadoLibreTests:** 
Unit tests.
- **Service** group: Unit tests for services and managers.
- **ViewControllers** group: Unit tests for ViewControllers.
- **Responses** group: Contains JSON files for subbed response calls.

## Dependencies
- **OHHTTPStubs:** Stubs network requests and allows to work with fake responses. [GitHub](https://github.com/AliSoftware/OHHTTPStubs)
- **Alamofire:** HTTP networking library. Used for handling API calls. [GitHub](https://github.com/Alamofire/Alamofire)
- **Lumberjack:** Logs library.  [GitHub](https://github.com/CocoaLumberjack/CocoaLumberjack)

## Usage
Open **BuscadorMercadoLibre.xcworkspace** to review code and run the application and tests.
