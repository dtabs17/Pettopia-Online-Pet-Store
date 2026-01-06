package pettopia.com.services;

import org.springframework.stereotype.Service;
import pettopia.com.dtos.DiscountCodeRequestDTO;
import pettopia.com.dtos.DiscountCodeResponseDTO;
import pettopia.com.entities.DiscountCode;
import pettopia.com.repositories.DiscountCodeRepository;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class AdminDiscountCodeService {

    private final DiscountCodeRepository discountCodeRepository;

    public AdminDiscountCodeService(DiscountCodeRepository discountCodeRepository) {
        this.discountCodeRepository = discountCodeRepository;
    }

    public List<DiscountCodeResponseDTO> getAllDiscountCodes() {
        List<DiscountCode> codes = discountCodeRepository.findAll();
        List<DiscountCodeResponseDTO> response = new ArrayList<>();

        for (DiscountCode code : codes) {
            response.add(mapToDTO(code));
        }

        return response;
    }

    public DiscountCodeResponseDTO getDiscountCodeById(Integer id) {
        DiscountCode code = discountCodeRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Discount code not found"));
        return mapToDTO(code);
    }

    public DiscountCodeResponseDTO createDiscountCode(DiscountCodeRequestDTO dto) {
        DiscountCode code = new DiscountCode();
        code.setCode(dto.getCode());
        code.setDescription(dto.getDescription());
        code.setDiscountType(dto.getDiscountType());
        code.setDiscountValue(dto.getDiscountValue());
        code.setStartDate(dto.getStartDate());
        code.setExpiryDate(dto.getExpiryDate());
        code.setUsageLimit(dto.getUsageLimit());
        code.setUsedCount(0);
        code.setActive(true);
        code.setCreatedAt(LocalDateTime.now());
        code.setUpdatedAt(LocalDateTime.now());

        discountCodeRepository.save(code);

        return mapToDTO(code);
    }

    public DiscountCodeResponseDTO updateDiscountCode(Integer id, DiscountCodeRequestDTO dto) {
        DiscountCode code = discountCodeRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Discount code not found"));

        code.setCode(dto.getCode());
        code.setDescription(dto.getDescription());
        code.setDiscountType(dto.getDiscountType());
        code.setDiscountValue(dto.getDiscountValue());
        code.setStartDate(dto.getStartDate());
        code.setExpiryDate(dto.getExpiryDate());
        code.setUsageLimit(dto.getUsageLimit());
        code.setUpdatedAt(LocalDateTime.now());

        discountCodeRepository.save(code);

        return mapToDTO(code);
    }

    public String toggleDiscountCode(Integer id) {
        DiscountCode code = discountCodeRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Discount code not found"));

        boolean newStatus = !code.getActive();
        code.setActive(newStatus);
        code.setUpdatedAt(LocalDateTime.now());

        discountCodeRepository.save(code);

        return newStatus ? "Discount code activated" : "Discount code archived";
    }

    public String deleteDiscountCode(Integer id) {
        DiscountCode code = discountCodeRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Discount code not found"));

        if (code.getUsedCount() != null && code.getUsedCount() > 0) {
            code.setActive(false);
            discountCodeRepository.save(code);
            return "Discount code has been used. Archived instead of deleted.";
        }

        discountCodeRepository.delete(code);
        return "Discount code deleted successfully";
    }

    private DiscountCodeResponseDTO mapToDTO(DiscountCode code) {
        return new DiscountCodeResponseDTO(
                code.getDiscountId(),
                code.getCode(),
                code.getDescription(),
                code.getDiscountType(),
                code.getDiscountValue(),
                code.getStartDate(),
                code.getExpiryDate(),
                code.getUsageLimit(),
                code.getUsedCount(),
                code.getActive()
        );
    }
}
