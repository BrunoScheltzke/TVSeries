# TVSeries

After cloning the project 
`$ git clone git@github.com:BrunoScheltzke/TVSeries.git`

Run the following command to install the dependencies
`$ pod install`

### Bonus
[x] Unlock with face/touch id
[x] Favorite/unfavorite tv series
[x] List favorited tv series and display details (not in alphabetic order)

### Code

- I have used the MVVM architecture. I chose this architecture as it's easy to use/understand, fast to develop and it's very scalable.
- All ViewModels are abstracted by protocols so it's easy to mock for unit testing (not included in the project)
- The ViewModels are injected in the viewcontroller through their init constructor. In order to make that happen, no storyboard was used.
- I don't have a dog in the xib/viewcoding fight. I like them both equally 😅. I think xibs are more visual while view coding makes it much better to code review.
- As I was doing this challenge alone and with limited time I decided to go with Xib files but I'm very familiar with ViewCode as well.
- Project includes a centralized APIService class with a function that uses Generics.
- Image caching is being accomplished by the ImageManager class (with protocol abstraction).

[Linkedin 💼](https://www.linkedin.com/in/brunoscheltzke/)
[Email ✉️](brunofonten@gmail.com)
