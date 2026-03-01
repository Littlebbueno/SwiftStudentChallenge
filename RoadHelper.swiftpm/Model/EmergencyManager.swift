//
//  EmergencyManager.swift
//  RoadHelper
//
//  Created by Marco Bueno on 26/02/26.
//
import SwiftUI

@Observable
class EmergencyManager {
    var immediateEmergencies: [Emergency] = []
    var roadWeatherEmergencies: [Emergency] = []
    var vehicleEmergencies: [Emergency] = []
    
    var traumaLifeSupportSteps = TraumaLifeSupport()
    var cprResuscitationSteps = CPRResuscitation()
    var vehicleFireSteps = VehicleFire()
    var animalHitSteps = AnimalHit()
    var safelyMoveSteps = SafelyMove()
    var flatTireSteps = FlatTire()
    var overheatingSteps = Overheating()
    var disabledVehicleSteps = DisabledVehicle()
    
    init(){
        loadEmergencies()
    }
    
    func loadEmergencies(){

        
        
        self.immediateEmergencies = [
            Emergency(title: "Trauma Life Support", image: "cross.case.fill", steps: self.traumaLifeSupportSteps.steps, category: 1, color: Color("Medical"), color2: Color("Medical"), links: [URLLink(title: "PHTLS Article", url: "https://tcc.univaco.edu.br/admin/uploads/2024_1%20Atendimento%20Pr%C3%A9-Hospitalar%20ao%20Trauma%20(PHTLS).pdf"), URLLink(title: "DETRAN First Aid Guidelines", url: "https://www.detraneduca.pr.gov.br/Pagina/Primeiros-Socorros"),URLLink(title: "Spinal Injury - Jaw Thrust", url: "https://www.youtube.com/watch?v=PdkgnRCoci4")]),
            Emergency(title: "CPR Resuscitation", image: "heart.fill", steps: self.cprResuscitationSteps.steps, category: 1, color: Color("CPREmergency"), color2: Color("CPREmergency2"), links: [URLLink(title:"CPR Manual for Adults: Manual MSD",url:"https://www.msdmanuals.com/pt/profissional/medicina-de-cuidados-cr%C3%ADticos/parada-card%C3%ADaca-e-reanima%C3%A7%C3%A3o-cardiopulmonar-rcp/reanima%C3%A7%C3%A3o-cardiopulmonar-rcp-em-adultos"), URLLink(title: "NHS Guidelines for Hands-Only CPR", url: "https://www.nhs.uk/tests-and-treatments/first-aid/cpr/")]),
            Emergency(title: "Vehicle Fire", image: "flame.fill", steps: self.vehicleFireSteps.steps, category: 1, color: Color("VehicleFire"), color2: Color("VehicleFire2"), links: [URLLink(title: "How to deal with a vehicle fire", url: "https://innovebrasil.org.br/carro-pegou-fogo/")]),
            Emergency(title: "Animal Hit", image: "pawprint.fill", steps: self.animalHitSteps.steps, category: 1, color: Color("AnimalHit"), color2: Color("AnimalHit"), links: [URLLink(title: "PMA Guidelines", url: "https://www.sejusp.ms.gov.br/manter-a-velocidade-permitida-em-rodovias-pode-evitar-o-atropelamento-de-animais-alerta-pma/"), URLLink(title: "GOV.BR: Injured Animal", url: "https://www.ms.gov.br/noticias/o-que-faco-se-encontrei-um-animal-silvestre-ferido-imasul-faz-orientacoes-e-recomenda-acionar-a-pma")]),
            Emergency(title: "Safely Moving a Victim", image: "person.fill", steps: self.safelyMoveSteps.steps, category: 1, color: .blue, color2: .blue, links: [URLLink(title: "UniFirst: How to Move an Injured Victim", url: "https://unifirstfirstaidandsafety.com/how-to-move-an-injured-victim/#:~:text=Lay%20the%20victim's%20arms%20along,out%20for%20obstacles%20behind%20you."),
                URLLink(title: "Rautek Maneuver", url: "https://pt.wikipedia.org/wiki/Chave_de_Rautek")])
        ]
        self.vehicleEmergencies = [
            Emergency(title: "Flat Tire", image: "tire", steps: self.flatTireSteps.steps, category: 2, color: Color("FlatTire"), color2: Color("FlatTire"), links: []),
            Emergency(title: "Overheating", image: "thermometer.high", steps: self.overheatingSteps.steps, category: 2, color: Color("Overheating"), color2: Color("Overheating2"), links: []),
            Emergency(title: "Disabled Vehicle", image: "exclamationmark.octagon.fill", steps: self.disabledVehicleSteps.steps, category: 1, color: Color("DisabledVehicle"), color2: Color("DisabledVehicle2"), links: [URLLink(title: "GOV.BR: Accidents", url: "https://www.gov.br/prf/pt-br/noticias/estaduais/parana/anteriores/2021/novembro/prf-orienta-motoristas-sobre-como-agir-em-casos-de-acidentes")])
        ]
        self.roadWeatherEmergencies = []
        
    }
}
