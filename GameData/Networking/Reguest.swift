
import Foundation
import UIKit
class Reguest{
    
    func loadData<T:Codable>(url:String,response:T.Type, complition:@escaping(Result<T,NSError>)->Void){
        
        guard let url = URL(string: url)else{return}
         
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard error == nil else{return}
            guard let data = data else {
                return
            }
            
            do{
              let  dataFromjson = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    complition(.success(dataFromjson))
                }
            }catch{
                print(error)
            }
            
            
        }
        task.resume()
    }
}
