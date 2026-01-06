package pettopia.com.services;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Service
public class ImageStorageService {

    @Value("${app.upload.dir:${user.home}/pettopia-images}")
    private String uploadDir;

    public String saveFile(MultipartFile file) throws IOException {
        if (file == null || file.isEmpty()) return null;

        String originalFilename = StringUtils.cleanPath(file.getOriginalFilename());
        String fileExtension = getFileExtension(originalFilename);
        String newFileName = UUID.randomUUID() + (fileExtension.isEmpty() ? "" : "." + fileExtension);

        Path targetLocation = Paths.get(uploadDir).resolve(newFileName);
        Files.createDirectories(targetLocation.getParent());
        Files.copy(file.getInputStream(), targetLocation, StandardCopyOption.REPLACE_EXISTING);

        return "/images/" + newFileName; // URL path returned
    }

    public List<String> saveFiles(MultipartFile[] files) throws IOException {
        List<String> urls = new ArrayList<>();
        if (files == null || files.length == 0) return urls;

        for (MultipartFile file : files) {
            String url = saveFile(file);
            if (url != null) urls.add(url);
        }
        return urls;
    }

    public void deleteFile(String url) throws IOException {
        if (url == null || url.isEmpty()) return;

        String filename = Paths.get(url).getFileName().toString();
        Path filePath = Paths.get(uploadDir).resolve(filename);
        Files.deleteIfExists(filePath);
    }

    public void deleteFiles(List<String> urls) throws IOException {
        if (urls == null || urls.isEmpty()) return;

        for (String url : urls) {
            deleteFile(url);
        }
    }

    private String getFileExtension(String filename) {
        if (filename == null) return "";
        int dotIndex = filename.lastIndexOf('.');
        return (dotIndex >= 0) ? filename.substring(dotIndex + 1) : "";
    }
}
