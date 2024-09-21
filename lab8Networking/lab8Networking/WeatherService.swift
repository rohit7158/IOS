import Foundation

struct WeatherService {
    func fetchWeatherData(lat: Double, lon: Double, completion: @escaping (Everything?, Error?) -> Void) {
        let apiKey = "3c86cdb94245fa2ca3d0c97d28abc112"  // Replace with your actual API key
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=Waterloo,ca&appid=\(apiKey)&units=metric"
       
        guard let url = URL(string: urlString) else {
            completion(nil, NSError(domain: "Invalid URL", code: 0, userInfo: nil))
            return
        }
        
        let urlSession = URLSession(configuration: .default)
        let dataTask = urlSession.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, NSError(domain: "No data", code: 0, userInfo: nil))
                return
            }
            
            let jsonDecoder = JSONDecoder()
            do {
                let readableData = try jsonDecoder.decode(Everything.self, from: data)
                completion(readableData, nil)
            } catch {
                print("Can't Decode: \(error.localizedDescription)")
                completion(nil, error)
            }
        }
        dataTask.resume()
    }
}

