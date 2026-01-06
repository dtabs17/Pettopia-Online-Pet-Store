package pettopia.com.controllers;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import pettopia.com.dtos.DiscountCodeRequestDTO;
import pettopia.com.dtos.DiscountCodeResponseDTO;
import pettopia.com.services.AdminDiscountCodeService;

import java.util.List;

@RestController
@RequestMapping("/api/admin/discount-codes")
public class AdminDiscountCodeController {

    private final AdminDiscountCodeService discountCodeService;

    public AdminDiscountCodeController(AdminDiscountCodeService discountCodeService) {
        this.discountCodeService = discountCodeService;
    }

    @GetMapping
    public ResponseEntity<List<DiscountCodeResponseDTO>> getAllDiscountCodes() {
        List<DiscountCodeResponseDTO> codes = discountCodeService.getAllDiscountCodes();
        return ResponseEntity.ok(codes);
    }

    @GetMapping("/{id}")
    public ResponseEntity<DiscountCodeResponseDTO> getDiscountCodeById(@PathVariable Integer id) {
        DiscountCodeResponseDTO code = discountCodeService.getDiscountCodeById(id);
        return ResponseEntity.ok(code);
    }

    @PostMapping
    public ResponseEntity<DiscountCodeResponseDTO> createDiscountCode(
            @RequestBody DiscountCodeRequestDTO dto) {
        DiscountCodeResponseDTO created = discountCodeService.createDiscountCode(dto);
        return ResponseEntity.ok(created);
    }

    @PutMapping("/{id}")
    public ResponseEntity<DiscountCodeResponseDTO> updateDiscountCode(
            @PathVariable Integer id,
            @RequestBody DiscountCodeRequestDTO dto) {
        DiscountCodeResponseDTO updated = discountCodeService.updateDiscountCode(id, dto);
        return ResponseEntity.ok(updated);
    }

    @PatchMapping("/{id}/toggle")
    public ResponseEntity<String> toggleDiscountCode(@PathVariable Integer id) {
        String result = discountCodeService.toggleDiscountCode(id);
        return ResponseEntity.ok(result);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<String> deleteDiscountCode(@PathVariable Integer id) {
        String result = discountCodeService.deleteDiscountCode(id);
        return ResponseEntity.ok(result);
    }
}
