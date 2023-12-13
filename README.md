# Weather App

This project is a culmination of the skills acquired during the [iOS & Swift - The Complete iOS App Development Bootcamp](https://www.udemy.com/course/ios-13-app-development-bootcamp) by Angela Yu on Udemy.


<img src="https://github.com/guilhermebrv/weather-app/assets/104163003/641671fd-8d92-4081-9d1d-1b8c43a529b6" width="180" height="400" />
<img src="https://github.com/guilhermebrv/weather-app/assets/104163003/7fc6362c-fc8d-494b-9258-e557e40e47aa" width="180" height="400" />

## Key Features

- **Dark Mode Support:** Enabled dark mode within the app, providing users with a visually comfortable experience in low-light environments.

- **Vector Assets:** Utilized vector assets to ensure high-quality and scalable graphics, enhancing the app's appearance on various screen sizes and resolutions.

- **Delegate Design Pattern:** Implemented the delegate design pattern to notify the controller of the user actions when searching for a city in the UITextField. This ensures a more modular architecture.

- **Networking Layer Implementation:** Designed a networking layer using URLSession to make the HTTP requests and communicate with the API to retrieve the weather data. Used also JSONDecoder, to facilitate parsing the JSON response, and dispatch queues, which ensure a smooth interaction with the main thread.

- **Error Handling:** Implemented comprehensive error handling during API communication to provide meaningful feedback to the developers that could be part of the project, in case of network issues or invalid responses.

- **Core Location Integration:** Incorporated Core Location to obtain the user's current location and make API requests using the user's coordinates. The app dynamically updates the user's current location on the interface.

## How to Use

1. **Clone the Repository:**
   ```bash
   git clone https://github.com/guilhermebrv/weather-app.git

2. **Open in Xcode:**
- Launch the project in Xcode and run it on your preferred iOS simulator or device.

3. **Explore the App:**
- Use the search functionality to look up the weather for a specific city.
- Experience the app seamlessly switching between light and dark modes based on user preferences.
- Enjoy accurate and up-to-date weather information presented in a user-friendly interface.

## Acknowledgments
- [OpenWeatherMap](https://openweathermap.org/): Thanks to OpenWeatherMap for providing the API that powers the weather data in this app.
- Angela Yu - Udemy Instructor: Grateful for the comprehensive iOS development course that inspired and equipped me to develop this weather app.
