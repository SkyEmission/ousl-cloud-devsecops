package com.ousl.cloudlab.dto;

import jakarta.validation.constraints.NotBlank;

public record StudentRequest(
        @NotBlank(message = "Registration number is required") String registrationNumber,
        @NotBlank(message = "Full name is required") String fullName,
        @NotBlank(message = "Course module is required") String courseModule
) {
}