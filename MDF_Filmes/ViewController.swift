            import UIKit
            import Alamofire
            import SwiftyJSON
            
            class ViewController: UIViewController {
                
                
                @IBOutlet weak var lblTexto: UILabel!
                
                @IBOutlet weak var imgImagem: UIImageView!
                
                
                override func viewDidLoad() {
                    super.viewDidLoad()
                    
                    let urlBase = "https://api.themoviedb.org/3/movie/329996?api_key="
                    let imgBase = "https://image.tmdb.org/t/p/w500"
                    let key = "1213e00ad70b3dada7681f1b85e44c22"
                    
                    let url = "\(urlBase)\(key)"
                    
                    Alamofire.request(url).responseJSON { (response) in
                        //essa função é assíncrona, então tudo o que é pra ser feito
                        //após a requisição deve ser colocado nesse closure
                        //e não na linha de baixo, pq a execução não é linear
                        //justamente por depender da resposta do servidor
                        
                        //site pra olhar o json mais claramente: http://jsoneditoronline.org
                        
                        if response.result.isSuccess {
                            let json = JSON(response.result.value!)
                            self.lblTexto.text = json["title"].stringValue
                            let imgPath = "\(imgBase)\(json["poster_path"].stringValue)"
                            let urlImage = URL(string: imgPath)
                            let bytes = try? Data(contentsOf: urlImage!)
                            let poster = UIImage(data: bytes!)
                            self.imgImagem.image = poster
                        }
                        
                        //colocar no info.plist as informações sobre fazer
                        //carregamento arbitrário OU especificar de onde será
                        //feito o carregamento (Allow Arbitrary Loads)
                    }
                }
            }
