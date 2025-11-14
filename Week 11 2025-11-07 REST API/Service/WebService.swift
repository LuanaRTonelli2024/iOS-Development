//
//  WebService.swift
//  API Example
//
//  Created by user285344 on 11/14/25.
//

import Foundation

//for the core API operations: GET, POST, PUT/PATCH, DELETE

//T --> template or a placeholder structure
//after validation of T we can store it as a Model [POST]
class WebService {
    //Methode: GET
    func downloadData<T: Codable>(fromURL: String) async -> T? {
        do {
            guard let url = URL(string: fromURL)
            else {
                throw NetworkError.badUrl
            }
            let (data, response) = try await URLSession.shared.data(from: url) //Fetching information from the url
            guard let response = response as? HTTPURLResponse
            else {
                throw NetworkError.badResponse
            }
            guard response.statusCode >= 200 && response.statusCode < 300
            else {
                throw NetworkError.badStatus
            }
            //store it in a T
            guard let decodedResponse = try? JSONDecoder().decode(T.self, from: data)
            else {
                throw NetworkError.failedToDecodeResponse
            }
            
            return decodedResponse
            
        } catch NetworkError.badUrl {
            print("There was an error creating the URL")
        }
        catch NetworkError.badResponse {
            print("Did not get a valid response")
        }
        catch NetworkError.badStatus {
            print("Did not get a 2xx status code from the response")
        }
        catch NetworkError.failedToDecodeResponse {
            print("Failed to decode response into the given type")
        }
        catch {
            print("An error occured downloading the data")
        }
        
        return nil
    }
}
