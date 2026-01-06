package pettopia.com.entities;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.time.LocalDateTime;

@Entity
@Table(name = "admin_users")
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
public class AdminUser {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer adminId;

    @Column(nullable = false, unique = true, length = 100)
    private String username;

    @Column(nullable = false, unique = true, length = 255)
    private String email;

    @Column(length = 255)
    @ToString.Exclude
    private String passwordHash;

    /**
     * Defines the access level or permissions assigned to this administrative user.
     * <p>
     * This field uses the {@link Role} enum, which represents different levels of
     * system access:
     * <ul>
     *   <li><b>admin</b> – full system privileges, including user and data management</li>
     *   <li><b>manager</b> – elevated permissions for operational or content management tasks</li>
     *   <li><b>staff</b> – standard user privileges, typically limited to day-to-day operations</li>
     * </ul>
     *
     * The default value is {@code Role.staff}, ensuring new admin users are created
     * with the lowest privilege level by default unless a higher role is explicitly assigned.
     * This mirrors the database column default of 'staff'.
     */
    @Enumerated(EnumType.STRING)
    @Column(length = 20)
    private Role role = Role.staff;

    /**
     * Represents the current operational state of the admin user account.
     * <p>
     * This field uses the {@link Status} enum, which can take one of the following values:
     * <ul>
     *   <li><b>ACTIVE</b> – the admin user account is enabled and can access the system</li>
     *   <li><b>INACTIVE</b> – the account exists but is temporarily disabled or suspended</li>
     * </ul>
     *
     * The default value is {@code Status.ACTIVE}, ensuring that new admin users
     * are considered active by default unless specified otherwise. This setting
     * corresponds to the database column default of 'active'.
     */
    @Enumerated(EnumType.STRING)
    @Column(length = 20)
    private Status status = Status.active;

    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private LocalDateTime lastLogin;

    @Lob
    private String notes;

    public enum Role { admin, manager, staff }
    public enum Status { active, inactive }


    public void setAdminId(Integer adminId) {
        this.adminId = adminId;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setPasswordHash(String passwordHash) {
        this.passwordHash = passwordHash;
    }

    public void setRole(Role role) {
        this.role = role;
    }

    public void setStatus(Status status) {
        this.status = status;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }

    public void setLastLogin(LocalDateTime lastLogin) {
        this.lastLogin = lastLogin;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    public Integer getAdminId() {
        return this.adminId;
    }

    public String getUsername() {
        return this.username;
    }

    public String getEmail() {
        return this.email;
    }

    public String getPasswordHash() {
        return this.passwordHash;
    }

    public Role getRole() {
        return this.role;
    }

    public Status getStatus() {
        return this.status;
    }

    public LocalDateTime getCreatedAt() {
        return this.createdAt;
    }

    public LocalDateTime getUpdatedAt() {
        return this.updatedAt;
    }

    public LocalDateTime getLastLogin() {
        return this.lastLogin;
    }

    public String getNotes() {
        return this.notes;
    }


}
