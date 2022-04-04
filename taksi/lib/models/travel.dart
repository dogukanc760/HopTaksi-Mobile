import 'dart:convert';

class Travel {
  String id;
  String userId;
  String providerId;
  bool isCash;
  String expectedTime;
  String licencePlate;
  String card;
  String paymentMethod;
  String startCity;
  String startLocation;
  String endLocation;
  String providerLocation;
  String calledHour;
  String startHour;
  String endHour;
  String whenProviderComed;
  String providerVehicle;
  String providerVehicleType;
  String providerRating;

  Travel(
      {this.id,
      this.userId,
      this.providerId,
      this.isCash,
      this.expectedTime,
      this.card,
      this.paymentMethod,
      this.startCity,
      this.startLocation,
      this.endLocation,
      this.providerLocation,
      this.calledHour,
      this.startHour,
      this.endHour,
      this.whenProviderComed,
      this.providerVehicle,
      this.providerVehicleType,
      this.licencePlate,
      this.providerRating});

  factory Travel.fromJson(Map<String, dynamic> json) {
    return Travel(
      id: json['id'],
      userId: json['userId'],
      providerId: json['providerId'],
      isCash: json['isCash'],
      expectedTime: json['expectedTime'],
      card: json['card'],
      paymentMethod: json['paymentMethod'],
      startCity: json['startCity'],
      startLocation: json['startLocation'],
      endLocation: json['endLocation'],
      providerLocation: json['providerLocation'],
      calledHour: json['calledHour'],
      startHour: json['startHour'],
      licencePlate: json['licencePlate'],
      endHour: json['endHour'],
      whenProviderComed: json['whenProviderComed'],
      providerVehicle: json['providerVehicle'],
      providerVehicleType: json['providerVehicleType'],
      providerRating: json['providerRating'],
    );
  }
}
