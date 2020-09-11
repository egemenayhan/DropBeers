# DropBeers
Case Study

DropBeers is beer brewer app. It gets customer input calculates how beers need to be brewed to satisfy all customers. Then lists them and shows beer details.  

### Installation:
Just open and run the project

### Project Structure:
I prefer MVVM-R pattern on my projects. MVVM-R is classic MVVM pattern with `State` and `Router` extensions. State is our data container which controlled by view model. Router is handling routing on view controller. For further information please check [this blog post](https://medium.com/commencis/using-redux-with-mvvm-on-ios-18212454d676). 

Presentations are used with necessary fields for related view to avoid full network object passing around app. 

I like to use stackview in dynamic interfaces for easier show/hide handling.

I use Carthage because of better build times.

### Third-party Libs:
- `Alamofire` for networking and image download & cache operations

### Things I would change If I had more time:
- Find better way to solve brewer problem
- Switch to collection view for list
- Fully scrollable detail page
- Partially loading handling for detail page
- Localize strings

### Things needed for production:
- Dynamic user input service.
- Crash tracking tool.
- Analysis tool for tracking user behaviour.
