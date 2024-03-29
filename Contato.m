//
//  Contato.m
//  ContatosIP67
//
//  Created by ios8207 on 2/5/19.
//  Copyright © 2019 vargas. All rights reserved.
//

#import "Contato.h"
#import <MapKit/MKAnnotation.h>

@implementation Contato

@dynamic nome,telefone,endereco,site,latitude,longitude,foto;

-(NSString *)description{
    return [NSString stringWithFormat:@"Nome: %@, Telefone: %@, Endereco: %@, Site: %@,Latitude: %@, Longitude: %@",self.nome, self.telefone, self.endereco, self.site, self.latitude, self.longitude];
}

-(CLLocationCoordinate2D)coordinate{
    return CLLocationCoordinate2DMake([self.latitude doubleValue], [self.longitude doubleValue]);
}

-(NSString *)title{
    return self.nome;
}

-(NSString *)subtitle{
    return self.site;
}
    
    

@end
